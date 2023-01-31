import { Module } from '@nestjs/common';
import { RecordsService } from './records.service';
import { UsersService } from '../users/users.service';
import { RecordsController } from './records.controller';

import { PrismaService } from '../prisma.service';

@Module({
  controllers: [RecordsController],
  providers: [RecordsService, PrismaService,UsersService],
  exports: [RecordsService],
})
export class RecordsModule {}
